// Code written by James Rosindell
// James@Rosindell.org
// This is not a tidy version for general distribution - please do not distribute 
// I will happily prepare a version for free general distribution if there is a demand for it.
// For relevant publications see 
// Rosindell et al. 2008 Ecological Informatics
// Rosindell et al. 2010 Ecology Letters


/************************************************************
						INCLUDES
************************************************************/

// standard inludes
# include <stdio.h>
# include <fstream>
# include <vector>
# include <iostream>
# include <string>
# include <math.h>
# include <time.h>
# include <ctime>

using namespace std;

/************************************************************
			 RANDOM NUMBER GENERATOR WRAPPER OBJECT
************************************************************/

# include "RandomWrap.cpp"

class NRrand {
  
private:
	// an object that contains the random number generator of choice
	RandomWrap X;
	// the last result (for normal deviates)
	double lastresult;
	// when doing normal deviates and values are in pairs
	// true when a new pair is needed, false when lastresult can be used
	bool normflag;
  
public:

	NRrand()
	{
		normflag = true;
	}

	void set_seed(long seed)
	{
		X.set_seed(seed);
	}
	
	double d01()
	{
		return X.d01();
	}  

	long i0(long max)
	// integer between 0 and max inclusive
	{
		return (long(floor(d01()*(max+1))));
	}

	double norm()
	// normal deviate
	{
		if (normflag)
		{
			double r2 = 2;
			double xx;
			double yy;
			while (r2>1)
			{
				xx=2.0*d01()-1.0;
				yy=2.0*d01()-1.0;
				r2=(xx*xx)+(yy*yy);
			}
			double fac=sqrt(-2.0*log(r2)/r2);
			lastresult = xx*fac;
			double result = yy*fac;
			normflag = false;
			return result;
		}
		else
		{
			normflag = true;
			return lastresult;
		}
	}

	double fattail(double z)
	// 2D fat tailed deviate
	{
		double result;
		result = pow((pow(d01(),(1.0/(1.0-z)))-1.0),0.5);
		return result;
	}

	double direction()
	// direction (for 2D fat tailed deviate)
	{
		double xx = 1.0 , yy = 1.0;
		while (xx*xx+yy*yy>1.0)
		{
			xx = d01();
			yy = d01();
		}
		return pow((xx/yy),2.0);
	}
	// to reconstruct distribution, use x = fattail/squrt(1+direction) , y = fattail/squrt(1+(direction^-1))

};

int octave_sort(long ab_in)
{
	long min = 1;
	long max = 2;
	int result = 1;
	while(!((ab_in < max)&&(ab_in >= min)))
	{
		min = min*2;
		max = max*2;
		result ++;
	}
	return result;
}


int dosim(long J, double speciationin)
{	
	// 3.84E+02	6.90E+01	5.64E-03
	
	// variables
	//long J = 5000;
	double m = 1.0;
    //1.0;//0.098;
	double tau_dash = 0.0;
	//double tau_dash = 0.000276;
	//double m = 1.0;
	//double speciationin = 0.006136; // rtest 4QB(1)
	double theta = speciationin*(J-1.0)/(1.0-speciationin); //47.8;
	
	long seed = 2;
	long num_runs = 30000;
	
	// working memory
	vector< long > local_community;
	long end_local;
	vector< long > meta_community;
	long end_meta;
	NRrand NR;
	NR.set_seed(seed);
	
	// output parameters
	vector< long > abundances;
	
	// averaged output parameters
	vector< double > av_abundances;
	av_abundances.clear();
	double av_richness;
	av_richness = 0;
	double av_A = 0;
	
	for (long run = 0 ; run < num_runs ; run ++)
	{
		//if (run % 1000 == 0)
		//{
		//	cout << " run = " << run << " \n";
		//}
		//setup
		meta_community.clear();
		local_community.clear();
		abundances.clear();
		end_meta = 0;
		for (long i = 0 ; i < J ; i ++)
		{
			local_community.push_back(1);
		}
		end_local = J;
		
		// local community coalescence
		while(end_local > 1)
		{
			double p_coal = double(end_local-1)/double(J-1);
			double p_no = (1.0 - m)*(1.0 - p_coal);
			if (NR.d01() <= (m/(m + (1.0-m)*p_coal)))
			{
				// immigration
				long index = NR.i0(end_local-1);
				meta_community.push_back(local_community[index]);
				end_meta ++;
				local_community[index] = local_community[end_local-1];
				end_local--;
			}
			else 
			{
				// coalescence
				long index1 = NR.i0(end_local-1);
				long index2 = NR.i0(end_local-2);
				if( index2 >= index1)
				{
					index2 ++;
				}
				local_community[index1] += local_community[index2];
				local_community[index2] = local_community[end_local-1];
				end_local--;
			}
		}
		meta_community.push_back(local_community[0]);
		end_meta ++;
		end_local --;
		
		//speciation limitation phase
		double gen = tau_dash;
		gen -= (-2.0/(double(end_meta*(end_meta-1))))*(log(NR.d01()));
		while (gen > 0)
		{
			long index1 = NR.i0(end_meta-1);
			long index2 = NR.i0(end_meta-2);
			if( index2 >= index1)
			{
				index2 ++;
			}
			meta_community[index1] += meta_community[index2];
			meta_community[index2] = meta_community[end_meta-1];
			end_meta--;		
			gen -= (-2.0/(double(end_meta*(end_meta-1))))*(log(NR.d01()));
		}
			
		av_A += end_meta;
		
		
		// speciation phase
		while (end_meta > 1)
		{
			if (NR.d01() <= (theta/(theta+double(end_meta -1))))
			{
				// speciation
				long index = NR.i0(end_meta-1);
				abundances.push_back(meta_community[index]);
				meta_community[index] = meta_community[end_meta-1];
				end_meta--;
			}
			else 
			{
				// coalescence
				long index1 = NR.i0(end_meta-1);
				long index2 = NR.i0(end_meta-2);
				if( index2 >= index1)
				{
					index2 ++;
				}
				meta_community[index1] += meta_community[index2];
				meta_community[index2] = meta_community[end_meta-1];
				end_meta--;
			}		
		}
		
		abundances.push_back(meta_community[0]);
		end_meta --;
		
		for (long i = 0 ; i < abundances.size() ; i ++)
		{
			while (abundances[i] >= av_abundances.size())
			{
				av_abundances.push_back(0.0);
			}
			av_abundances[abundances[i]] += 1.0;
			av_richness += 1.0;
		}
	}
	ofstream out;
	out.open("Fybos_C2b.csv");
	
	for (long i = 0 ; i < av_abundances.size() ; i ++)
	{
		av_abundances[i] = av_abundances[i]/double(num_runs);
		out << av_abundances[i] << " , \n";
	}
	av_richness = av_richness/double(num_runs);
	out << "\n";
	vector < double > octaves;
	octaves.clear();
	for (int i = 0 ; i < 16 ; i ++)
	{
		octaves.push_back(0.0);
	}
	for (long i = 1 ; i < av_abundances.size() ; i ++)
	{
		octaves[octave_sort(i)] += av_abundances[i];
	}
	
	double numind = 0;
	for (long i = 0 ; i < av_abundances.size() ; i ++)
	{
		numind += av_abundances[i]*double(i);
	}
	cout << numind << " total individuals = " << J << " \n";
	
	cout << av_richness << " || ";
	for (int i = 1 ; i < octaves.size() ; i ++)
	{
		cout << octaves[i] << " , ";
	}
	cout << " \n";
	
	cout << av_A/double(num_runs) << " AVA \n";
	
	
	out << av_richness << " || ";
	for (int i = 1 ; i < octaves.size() ; i ++)
	{
		out << octaves[i] << " , ";
	}
	out << " \n";
	out.close();

    return 0;
}

int main()
{
    
    double speciationin =  0.1;
    cout << "500 size \n";
    dosim(500, speciationin);
    cout << "1000 size \n";
    dosim(1000, speciationin);
    cout << "2500 size \n";
    dosim(2500, speciationin);
    cout << "5000 size \n";
    dosim(5000, speciationin);
   
   }
   
					
					
					
					
					
					
