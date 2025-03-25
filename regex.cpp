#include <iostream>
#include <regex>
#include <vector>

using namespace std;

bool coincide_expresion(const string &palabra) {
    regex patron(R"(^a(l(budeite|mirez)|ta(mbal|nin)|raq))"); // Expresión regular
    return regex_match(palabra, patron);
}

void probar_expresion() {
    vector<string> palabras = {
        "albudeite", "almirez", "atambal", "atanin", "araq",
        "alba", "atamin", "a", "albur", "albañil", "at"
    };

    for (const auto &palabra : palabras) {
        cout << palabra << " -> " << (coincide_expresion(palabra) ? "Coincide" : "No coincide") << endl;
    }
}

int main() {
    probar_expresion();
    return 0;
}
