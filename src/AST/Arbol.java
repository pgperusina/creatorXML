package AST;

import java.util.LinkedList;

public class Arbol implements NodoAST {

    public LinkedList<NodoAST> Etiquetas;

    public Arbol(LinkedList<NodoAST> etiquetas) {
        Etiquetas = etiquetas;
    }

    @Override
    public Object ejecutar() {
        return null;
    }

    public String toString() {
        return this.Etiquetas.toString();
    }
}
