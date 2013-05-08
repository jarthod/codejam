#include <iostream>
#include <fstream>

using namespace std;

int main(int argc, char const *argv[])
{
  if (argc >= 1) {
    ifstream  file;
    int       cases;

    file.open(argv[1]);
    file >> cases;
    for (int c = 0; c < cases; c++) {
      cout << "Case #" << c+1 << ":" << endl;
    }
    file.close();
    return 0;
  }
  return 1;
}