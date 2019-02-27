package AST;

import java.util.LinkedList;

public class Etiqueta implements NodoAST{

    private TagInicial tagInicio;
    private String tagFinal;
    private String nombre;
    private ListaAtributos listaAtributos;
    private LinkedList<NodoAST> cuerpoEtiqueta;

    public Etiqueta(TagInicial tagInicio, String tagFinal, LinkedList<NodoAST> cuerpoEtiqueta) {
        this.tagInicio = tagInicio;
        this.tagFinal = tagFinal;
        this.cuerpoEtiqueta = cuerpoEtiqueta;
    }

    public TagInicial getTagInicio() {
        return tagInicio;
    }

    public void setTagInicio(TagInicial tagInicio) {
        this.tagInicio = tagInicio;
    }

    public String getTagFinal() {
        return tagFinal;
    }

    public void setTagFinal(String tagFinal) {
        this.tagFinal = tagFinal;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public LinkedList<NodoAST> getCuerpoEtiqueta() {
        return cuerpoEtiqueta;
    }

    public void setCuerpoEtiqueta(LinkedList<NodoAST> cuerpoEtiqueta) {
        this.cuerpoEtiqueta = cuerpoEtiqueta;
    }

    @Override
    public Object ejecutar() {
        return null;
    }

    public String toString() {
        return this.tagInicio.getNombre();
    }
}
