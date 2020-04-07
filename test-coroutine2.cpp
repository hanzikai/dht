#include <iostream>
#include <boost/range.hpp>
#include <boost/coroutine2/all.hpp>

using namespace std;
int main()
{
    typedef boost::coroutines2::coroutine<int>   coro_int2;
    std::cout<< "start corountine" << std::endl;
    coro_int2::pull_type source(
            [&](coro_int2::push_type& sink){
                std::cout<< " sink1" << std::endl;  
                sink(1); // push {1} back to main-context
                std::cout<< " sink2" << std::endl;
                sink(2); // push {2} back to main-context
                std::cout<< " sink3" << std::endl;
                sink(3); // push {3} back to main-context
            }
        );
    std::cout<< "start while" << std::endl;
    while(source)    // test if pull-coroutine is valid
    {
        int ret=source.get(); // pushed data,that is the argument of sink()
        std::cout<< "move to coroutine-function "<< ret << std::endl;
        source();             // context-switch to coroutine-function
        std::cout<< "back from coroutine-function "<< std::endl;
    }
    return 0;
}
