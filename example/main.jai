#import "Basic";
#import "Symbols";
// #insert #run loadex("test.jai", "rps.txt", debug=false); // using custom replacement file "rps.txt"
#insert #run loadex("test.jai", debug=false);

main :: () {
    print("foo %\n", foo(2.0));
}