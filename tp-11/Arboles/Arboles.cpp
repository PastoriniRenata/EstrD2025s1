#include <iostream>
using namespace std;
#include "Arboles.h"

Tree emptyT(){
    return NULL;
}

Tree nodeT(int elem, Tree left, Tree right){
    NodeT* tree = new NodeT;

    tree->elem =  elem;
    tree->left = left;
    tree->right= right;

    return tree;
}

bool isEmptyT(Tree t){
    return t==NULL;
}

int rootT(Tree t){
    if(t==NULL){
        exit(1);
    }

    return t->elem;
}

Tree left(Tree t){
    if(t==NULL){
        exit(1);
    }
    return t->left;
}

Tree right(Tree t){
    if(t==NULL){
        exit(1);
    }
    return t->right;
}







