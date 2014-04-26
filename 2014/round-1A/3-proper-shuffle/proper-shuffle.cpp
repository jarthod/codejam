#include <iostream>
#include <fstream>
#include <cstdlib>

using namespace std;

const int N = 1000;
const int AVG = 5000000;

void bad_permutation(int arr[])
{
  for(int k = 0; k < N; ++k)
    arr[k] = k;
  for(int k = 0; k < N; ++k)
  {
    int p = rand() % N;
    int swap = arr[k];
    arr[k] = arr[p];
    arr[p] = swap;
  }
}

void bad_distribution_mean(float arr[])
{
  for(int i = 0; i < N; ++i)
    arr[i] = 0;
  for(int a = 0; a < AVG; a++)
  {
    int bad[N];
    bad_permutation(bad);
    for(int i = 0; i < N; ++i)
      arr[i] += bad[i];
  }
  for(int i = 0; i < N; ++i)
    arr[i] /= AVG;
}

int main(int argc, char const *argv[])
{
  float bad_mean[N];
  bad_distribution_mean(bad_mean);
  cout << "[";
  for (int i = 0; i < N; i++)
  {
    if (i > 0)
      cout << ", ";
    cout << bad_mean[i];
  }
  cout << "]" << endl;
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