//
//  WeakSymbol.h
//  TestSymbol
//
//  Created by ws on 2021/1/15.
//

void weak_function(void)  __attribute__((weak));
void weak_hidden_function(void) __attribute__((weak, visibility("hidden")));



