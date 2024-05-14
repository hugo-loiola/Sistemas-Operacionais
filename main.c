#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

typedef struct
{
  char Nome[50];
  int HP;
  int Atk;
  int Dfs;

} Pokemon;

Pokemon criarPokemon(char Nome[50], int HP, int Atk, int Dfs);
void mostrarPokemon(Pokemon X);

int main()
{
  // Criar um pokémon
  Pokemon X = criarPokemon("Charmander", 100, 12, 32);
  mostrarPokemon(X);
  return 0;
}

Pokemon criarPokemon(char Nome[50], int HP, int Atk, int Dfs)
{
  Pokemon novoPokemon;
  strcpy(novoPokemon.Nome, Nome);
  novoPokemon.HP = HP;
  novoPokemon.Atk = Atk;
  novoPokemon.Dfs = Dfs;
  return novoPokemon;
}

void mostrarPokemon(Pokemon X)
{
  printf("O Pokémon %s possui HP: %d, Atk: %d, Dfs: %d\n", X.Nome, X.HP, X.Atk, X.Dfs);
}
