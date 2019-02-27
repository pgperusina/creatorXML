package AST;

public class Atributo implements NodoAST{

    private String nombre;
    private String valor;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public Atributo(String nombre, String valor) {
        this.setNombre(nombre);
        this.setValor(valor);
    }

    @Override
    public Object ejecutar() {
        return null;
    }

    public String toString() {
        return this.nombre + " = " + this.valor;
    }
}