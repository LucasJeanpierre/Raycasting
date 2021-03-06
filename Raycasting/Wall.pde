public class Wall {
    private int x1;
    private int y1;

    private int x2;
    private int y2;

    color c;

    public Wall(int x1, int y1, int x2, int y2, color c) {
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
        this.c = c;
    }

    public void show() {
        stroke(c);
        line(this.x1, this.y1, this.x2, this.y2);
        noStroke();
    }
}
