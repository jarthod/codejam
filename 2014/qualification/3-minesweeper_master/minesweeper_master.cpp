#include <iostream>
#include <fstream>
#include <string.h>

using namespace std;

class Board
{
public:
  Board(int rows, int cols)
  {
    this->rows = rows;
    this->cols = cols;
    for (int r = 0; r < rows; ++r)
    {
      memset (cells[r],'*',cols);
      cells[r][cols] = '\0';
    }
    cells[0][0] = 'c';
  };

  int   size() const
  {
    return rows * cols;
  }

  void  print() const
  {
    for (int r = 0; r < rows; ++r)
      cout << cells[r] << endl;
  };

  int rows, cols;
  char cells[50][50];
};

int solve(Board board&, int mines)
{

}

int main(int argc, char const *argv[])
{
  if (argc >= 1) {
    ifstream  file;
    int       cases;

    file.open(argv[1]);
    file >> cases;
    for (int c = 0; c < cases; c++) {
      int rows, cols, mines;
      file >> rows >> cols >> mines;
      Board board(rows, cols);
      cout << "Case #" << c+1 << ":" << endl;
      if (board.size() - mines == 1)
        board.print();
      else if (board.size() - mines == 0)
        cout << "Impossible" << endl;
      else
        solve(board, mines);
    }
    file.close();
    return 0;
  }
  return 1;
}