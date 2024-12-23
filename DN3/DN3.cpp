#include <iostream>
#include <cmath>
using namespace std; //da ne rabim pisat std:: ... vsakic

//Taylorjeva vrsta ArcTan
int N_steps = 100; // Globalna spremenljivka za calcAtan

double calcAtan(double x, int N_steps) {
    double output = 0; // 
    for (int i = 0; i <= N_steps; i++) { 
        output += pow(-1, i) * (pow(x, 2 * i + 1)) / (2 * i + 1); 
    }
    return output; // Vrne izracunano vrednost arctan(x)
}
//e^(3x)* arctan(x/2)
double funkcija(double x) {
    double vrednost = exp(3 * x) * calcAtan(x / 2, N_steps
    ); 
    return vrednost;
}

//integriranje z trapezno metodo
double integral(double a, double b, int n) {
    double h = (b - a) / n;
    double k = 0;
    double rezultat = 0;
    for (int i = 0; i <= n; i++) {
        double x = a + i * h;
        if (i == 0 || i == n) {
            k = 0.5;
        }
        else {
            k = 1;
        }
        rezultat += k * h * funkcija(x);
    }
    return rezultat;
}

int main() {
    // Izracun integrala
    const double pi = 3.141592653589793238462643383279502884;
    double a = 0;
    double b = pi / 4;
    double n = 1000;
    cout << "RESITEV: " <<integral(a, b, n)<< endl;
    //RESITEV = 0.8244
    return 0;
}

