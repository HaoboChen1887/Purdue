class IntList implements MyList{
    int data;
    IntList next;

    public IntList(int data){
        this.data = 0;
        this.next = null;
    }

    public IntList(IntList n, int data){
        this.data = data;
        if(n.next == null){
            this.next = n;
        }
        else {
            this.next = n;
        }
    }

    public int getData() {
        return data;
    }

    public IntList next(){
        return this.next;
    }

    public void printNode() {
        System.out.print("IntList Node, data is: " + data);
    }
}