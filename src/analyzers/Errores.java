package usac.compiladores;

import java.util.LinkedList;

public class Errores {

    private static LinkedList<Error> errores = new LinkedList<>();

    public static void agregarError(Error error) {
        errores.add(error);
    }

    public LinkedList<Error> verErrores(){
        return errores;
    }
}
