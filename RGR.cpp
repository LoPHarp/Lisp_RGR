#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
#include <iomanip> 

using namespace std;

int main() 
{
    vector<double> F(21);
    F[1] = 1.0;
    F[11] = 1.0;

    for (int i = 2; i <= 10; i++) 
        F[i] = log(F[i - 1]) + i / 2.0;  

    for (int i = 12; i <= 20; i++) 
        F[i] = 2 * cos(F[i - 1] + sin(2 * i));

    ofstream outfile("cpp_results.txt");
    if (outfile.is_open()) 
    {
        outfile << fixed << setprecision(10);
        for (int i = 1; i <= 20; i++) 
            outfile << F[i] << endl;
        outfile.close();
        cout << "File 'cpp_results.txt' created." << endl;
    }
    else 
        cout << "Error opening file!" << endl;

    return 0;
}