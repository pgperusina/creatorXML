package AST;

public class TagInicial implements NodoAST {

    private String nombre;
    public ListaAtributos listaAtributos;

    public TagInicial(String nombre, ListaAtributos listaAtributos) {
        this.nombre = nombre;
        this.listaAtributos = listaAtributos;
    }

    public TagInicial(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @Override
    public Object ejecutar() {
        return null;
    }
}
