#include <iostream>
#include <fstream>
#include <vector>
#include <map>
#include <cstring>

using namespace std;

typedef pair<string, int> cache_key;
map<char, vector<string> > dictionary;
vector<string> words;
map<cache_key, int> cache;
const int infinity = 1 << 30;

int min_changes(string email, int last_alter = 5, string candidate = "")
{
  if(email == "")
    return(candidate == "" ? 0 : infinity);
  else if(candidate != "")
  {
    if(email[0] == candidate[0]) // word still match
      return min_changes(email.substr(1), last_alter+1, candidate.substr(1));
    else if(last_alter >= 5) // a letter could have changed
      return 1 + min_changes(email.substr(1), 1, candidate.substr(1));
    else // don't match
      return infinity;
  }
  else
  {
    // cout << "min_changes " << email << " (" << last_alter << "), " << candidate << endl;
    if(cache[cache_key(email, last_alter)])
      return cache[cache_key(email, last_alter)];
    int min = infinity;
    vector<string> &indexed_words = dictionary[email[0]];
    for(int i = 0; i < indexed_words.size(); i++)
    {
      string &word = indexed_words[i];
      int sub_changes = min_changes(email.substr(1), last_alter+1, word.substr(1));
      if(sub_changes < min)
        min = sub_changes;
      if(min == 0)
        break;
    }
    if(min > 0 && last_alter >= 5)
    {
      for(int i = 0; i < words.size(); i++)
      {
        string &word = words[i];
        int sub_changes = 1 + min_changes(email.substr(1), 1, word.substr(1));
        if(sub_changes < min)
          min = sub_changes;
        if(min == 1)
          break;
      }
    }
    cache[cache_key(email, last_alter)] = min;
    return min;
  }
}


int main(int argc, char const *argv[])
{
  ifstream  dic_file;
  dic_file.open("dictionary.txt");
  for(int i = 0; i < 521196; i++)
  {
    string word;
    dic_file >> word;
    words.push_back(word);
    dictionary[word[0]].push_back(word);
  }

  if (argc >= 1) {
    ifstream  file;
    int       cases;

    file.open(argv[1]);
    file >> cases;
    for (int c = 0; c < cases; c++) {
      string email;
      file >> email;
      cout << "Case #" << c+1 << ": " << min_changes(email) << endl;
    }
    file.close();
    return 0;
  }
  return 1;
}