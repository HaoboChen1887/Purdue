class LongList implements MyList{
    long data;
    LongList next;

    public LongList(int data){
        this.data = 0;
        this.next = null;
    }

    public LongList(LongList n, long data){
        this.data = data;
        if(n.next == null){
            this.next = n;
        }
        else {
            this.next = n;
        }
    }

    public long getData() {
        return data;
    }

    public LongList next(){
        return this.next;
    }

    public void printNode() {
        System.out.print("LongList Node, data is: " + data);
    }
}
