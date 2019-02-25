package usac.compiladores;

public class Error {

    private String textoError;
    private int linea;
    private int columna;

    public String getTextoError() {
        return textoError;
    }

    public void setTextoError(String textoError) {
        this.textoError = textoError;
    }

    public int getLinea() {
        return linea;
    }

    public void setLinea(int linea) {
        this.linea = linea;
    }

    public int getColumna() {
        return columna;
    }

    public void setColumna(int columna) {
        this.columna = columna;
    }

    public Error(String textoError, int linea, int columna) {
        this.textoError = textoError;
        this.linea = linea;
        this.columna = columna;
    }
}
