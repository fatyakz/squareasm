#include <iostream>
#include <ctime>
#include <string>
#include <locale>
#include <iomanip>
#include <iostream>

using namespace std;

extern "C" long long squareASM();
/*
class comma_numpunct : public std::numpunct<char>
{
protected:
	virtual char do_thousands_sep() const {	return ',';	}
	virtual std::string do_grouping() const	{ return "\03";	}
};

// set locale hack to use commas in iostream
std::locale comma_locale(std::locale(), new comma_numpunct());
*/
int main() {
	long startTime = clock();
	long long result = squareASM();
	cout << "SquareASM: RAX=" << result << endl;
	long finishTime = clock();
	double thisTime = (finishTime - startTime) / (double)CLOCKS_PER_SEC;
	std::cout << "Time: " << thisTime << "s" << endl;
	if (thisTime > 1) {
		std::cout << result / thisTime << " cycles per second" << endl;
	}
	return 0;
}