#include <iostream>

using namespace std;

extern "C" int SomeFunction();

int main() {
	cout << "Result: " << SomeFunction() << endl;

	return 0;
}