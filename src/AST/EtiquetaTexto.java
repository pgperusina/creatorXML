package AST;

public class EtiquetaTexto implements NodoAST {

    public StringBuilder texto;

    public EtiquetaTexto(StringBuilder texto) {
        this.texto = texto;
    }

    @Override
    public Object ejecutar() {
        return null;
    }
}
