package uqac.aop.chess;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Objects;

import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.Board;
import edu.uqac.aop.chess.piece.Piece;


public aspect test {

    private int counter = 0;

    pointcut callDemoAspectPointCut():
            execution(* edu.uqac.aop.chess.agent.HumanPlayer.makeMove());

    after() returning(Object r) : callDemoAspectPointCut() {

        //System.out.println("Return value: " + r.toString()); // getting return value

        try {
            FileWriter fw = new FileWriter("output.txt", true);
            BufferedWriter bw = new BufferedWriter(fw);

            if (this.counter == 0) {
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                LocalDateTime now = LocalDateTime.now();
                //System.out.println(dtf.format(now));
                bw.write("\n====================================\n====================================\n\n");
                bw.newLine();
                bw.write(dtf.format(now));
                bw.newLine();
            }
            bw.write("Human player à joué " + r.toString());
            bw.newLine();
            bw.close();
            this.counter += 1;
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

aspect test2 {
    private int counter = 0;

    pointcut callDemoAspectPointCut():
            execution(* edu.uqac.aop.chess.agent.AiPlayer.makeMove());

    after() returning(Object r) : callDemoAspectPointCut() {

        //System.out.println("Return value: " + r.toString()); // getting return value

        try {
            FileWriter fw = new FileWriter("output.txt", true);
            BufferedWriter bw = new BufferedWriter(fw);

            if (this.counter == 0) {
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                LocalDateTime now = LocalDateTime.now();
                //System.out.println(dtf.format(now));
                bw.write("\n====================================\n====================================\n\n");
                bw.newLine();
                bw.write(dtf.format(now));
                bw.newLine();
            }
            bw.write("AiPlayer à joué : " + r.toString());
            bw.newLine();
            bw.close();
            this.counter += 1;
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

aspect test3 {

    private Piece startingPiece;
    private Piece endingPiece;
    private Board playground;
    private int player = 0;


    pointcut callDemoAspectPointCut(Move mv, Board playground):
            (call(boolean edu.uqac.aop.chess.agent.Player.makeMove(Move, Board)) && args(mv, playground));

    private void checkIsLegal(Piece piece, Move mv) {
        if (!piece.isMoveLegal(mv)) {
            System.out.println("Move illegal");
            mv.canMove = false;
        }
        else {
            System.out.println("legal move");
        }
    }

    private void isPlayerPieceHit(Move mv) {
        if (this.startingPiece.getPlayer() == this.endingPiece.getPlayer()) {
/*            System.out.println(this.startingPiece.getPlayer());
            System.out.println(this.endingPiece.getPlayer());
            System.out.println("pièce au même joueur");*/
            mv.canMove = false;
        } else {
              mv.canMove = true;
            //errorDetected = false;
        }
    }

    private void isPlayerPiece(Move mv) {


        if (mv.human) {
            if (this.startingPiece.getPlayer() == 0) {
                System.out.println("Cette pièce t'appartient pas");
                mv.canMove = false;
            }
        } else {
            if (this.startingPiece.getPlayer() == 1) {
                System.out.println("Cette pièce t'appartient pas");
                mv.canMove = false;
            }
        }

    }

    private boolean checkInBoard(Move mv) {

        if ((mv.xI < 0 || mv.xI > 7) || (mv.yI < 0 || mv.yI > 7)) {
            System.out.println("Cette pièce n'est pas dnas l'échéquier");
            mv.canMove = false;
            return false;
        }

        if ((mv.xF < 0 || mv.xF > 7) || (mv.yF < 0 || mv.yF > 7)) {
            System.out.println("Ce coup sort de l'échéquier");
            mv.canMove = false;
            return false;
        }
        return true;
    }

    private boolean isDiagonalMOve(Move mv) {
        if (mv.xI != mv.xF)
            return true;
        else
            return false;
    }

    private void checkPieceMovement(Move mv) {
/*        System.out.println("Piece qui bouge : " + piece.toString() + "player : " + piece.getPlayer());
        System.out.println("Coup : : x:" + mv.xI + "y:" +  mv.yI);
        System.out.println("Coup finale : x:" + mv.xF + "y:" +  mv.yF);
        System.out.println("Emplacement final  : " + playground.getGrid()[mv.xF][mv.yF].getPiece());
*/
        if (Objects.equals(playground.getGrid()[mv.xI][mv.yI].getPiece().toString(), "C") ||
                Objects.equals(playground.getGrid()[mv.xI][mv.yI].getPiece().toString(), "c"))
        {
            return;
        }

        if (Objects.equals(playground.getGrid()[mv.xI][mv.yI].getPiece().toString(), "P") ||
                Objects.equals(playground.getGrid()[mv.xI][mv.yI].getPiece().toString(), "p"))
        {
            if (!playground.getGrid()[mv.xF][mv.yF].isOccupied() && isDiagonalMOve(mv)) {
                System.out.println("Vous ne pouvez pas jouer ce coup avec le pion");
                mv.canMove = false;
                return;
            }
        }

        //if (mv.xI < mv.xF) {

        if (mv.xI <= mv.xF && mv.yI <= mv.yF) {
            for (int x = mv.xI; x <= mv.xF; x++) {
                for (int y = mv.yI + 1; y <= mv.yF - 1; y++) {
                    if (playground.getGrid()[x][y].isOccupied()) {

                        System.out.println("Vous êtes bloqués par une pièce");
                        mv.canMove = false;
                        return;
                    }
                 }
            }
        }
        if (mv.xI <= mv.xF && mv.yI >= mv.yF) {
            for (int x = mv.xI; x <= mv.xF && x >= 0; x++) {
                for (int y = mv.yI - 1; y >= mv.yF + 1; y--) {
                    if (playground.getGrid()[x][y].isOccupied()) {

                        System.out.println("Vous êtes bloqués par une pièce");
                        mv.canMove = false;
                        return;
                    }
                }
            }
//            return;

        }
        if (mv.xI >= mv.xF && mv.yI <= mv.yF) {
            for (int x = mv.xI; x >= mv.xF; x--) {
                for (int y = mv.yI + 1; y <= mv.yF - 1; y++) {
                    if (playground.getGrid()[x][y].isOccupied()) {

                        System.out.println("Vous êtes bloqués par une pièce");
                        mv.canMove = false;
                        return;
                    }
                }
            }
        }
        if (mv.xI >= mv.xF && mv.yI >= mv.yF) {
            for (int x = mv.xI; x >= mv.xF; x--) {
                for (int y = mv.yI - 1; y >= mv.yF + 1; y--) {
                    if (playground.getGrid()[x][y].isOccupied()) {

                        System.out.println("Vous êtes bloqués par une pièce");
                        mv.canMove = false;
                        return;
                    }
                }
            }
        }


        //}
        /*else {
            for (int x = mv.xI; x >= mv.xF; x--) {
                for (int y = mv.yI -1; y >= mv.yF - 1; y--) {
                    if (playground.getGrid()[x][y].isOccupied()) {

                        System.out.println("Vous êtes bloqués par une pièce");
                        mv.canMove = false;
                        return;
                    }
                }
            }
        }

        /*if (mv.xI <= mv.xF && mv.yI < mv.yF) {

            for (int x = mv.xI; x <= mv.xF; x++) {
                for (int y = mv.yI + 1; y <= mv.yF - 1; y++) {
                    if (playground.getGrid()[x][y].isOccupied()) {

                        System.out.println("Vous êtes bloqués par une pièce");
                        mv.canMove = false;
                        return;
                    }
                }
            }
        }

        /*if (mv.xI >= mv.xF && mv.yI < mv.yF) {

            for (int x = mv.xI; x >= mv.xF; x--) {
                for (int y = mv.yI + 1; y <= mv.yF - 1; y++) {
                    if (playground.getGrid()[x][y].isOccupied()) {

                        System.out.println("Vous êtes bloqués par une pièce");
                        mv.canMove = false;
                        return;
                    }
                }
            }
        }*/

        /*if (mv.xI <= mv.xF && mv.yI > mv.yF) {

            for (int x = mv.xI; x <= mv.xF; x++) {
                for (int y = mv.yI + 1; y >= mv.yF + 1; y--) {
                    if (playground.getGrid()[x][y].isOccupied()) {

                        System.out.println("Vous êtes bloqués par une pièce");
                        mv.canMove = false;
                        return;
                    }
                }
            }
        }

/*        if (mv.xI >= mv.xF && mv.yI > mv.yF) {

            for (int x = mv.xI; x >= mv.xF; x--) {
                for (int y = mv.yI + 1; y >= mv.yF + 1; y--) {
                    if (playground.getGrid()[x][y].isOccupied()) {

                        System.out.println("Vous êtes bloqués par une pièce");
                        mv.canMove = false;
                        return;
                    }
                }
            }
        }*/

    }

    boolean around(Move mv, Board bd): callDemoAspectPointCut(mv, bd) {
        this.playground = bd;
        boolean result = false;

        System.out.println("Move : " + mv.toString());

        if (mv == null) {
            System.out.println("Impossible de réaliser ce déplacement.");
        }
        if (!checkInBoard(mv)) {
            return false;
        }

        if (playground.getGrid()[mv.xI][mv.yI].isOccupied()) {
            this.startingPiece = playground.getGrid()[mv.xI][mv.yI].getPiece();
            isPlayerPiece(mv);
            if (playground.getGrid()[mv.xF][mv.yF].isOccupied()) {
                this.endingPiece = playground.getGrid()[mv.xF][mv.yF].getPiece();
                isPlayerPieceHit(mv);
            }
            checkIsLegal(this.startingPiece, mv);
            if (mv.canMove) {
                checkPieceMovement(mv);
            }
        }
        else {
            System.out.println("Case vide, impossible de jouer ce coup");
            mv.canMove = false;
        }
        if (!mv.canMove)
            mv = null;
        result = proceed(mv, bd);

        return result;
    }
}