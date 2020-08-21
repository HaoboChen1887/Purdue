class Main {                                         

   public static int[ ][ ] A;
   public static int[ ][ ] B;
   public static int[ ][ ] C;

   public static int N;
   public static int numThreads;

   // Change this to hold MM references
   private static Thread[ ] threads;

   // Code to self initialize the array.

   public static void fill( ) {
      C = new int[N][N];
      A = new int[N][N];
      B = new int[N][N];
      for (int i = 0; i < N; i++) { 
         for (int j = 0; j < N; j++) { 
            C[i][j]  = 0;
            A[i][j]  = 1;
            B[i][j]  = 1;
         }
      }
   }

   // Print an array.  If the array is large only some elements are printed.
   public static void printArray(int N, int ary[][], String s) { 
      int step;
      if (N > 16) step = N / 16;
      else step = 1;
   
      System.out.println(s);
      for (int i = 0; i < N; i+=step) {
         for (int j = 0; j < N; j+=step) {
            System.out.print(ary[i][j]+" ");
         }
         System.out.println( );
      }
      System.out.println( );
      System.out.println( );
   }
      

   public static void main( String[] args ) {           
      
      if (args.length != 2) {
         System.out.println("Usage: java Main #threads arraySize");
         System.exit(-1);
      }

      numThreads = Integer.valueOf(args[0]);
      N = Integer.valueOf(args[1]);

      // Allocate storage to hold MM object references
      threads = new Thread[numThreads];

      boolean done = false;
      while (!done) {
         fill( );
         done = true;
      }

      // Replace with code to start and run the matrix multiplies on each thread
      //new MM(1, N).run( );
      for (int i = 0; i < numThreads; i++){
         threads[i] = new MM(4, N / numThreads);
         threads[i].start();
      }

      // Replace with code that:
      // waits until all threads have finished executing
      // As each thread finishes see if it is the longest executing thread so
      // far, and if it is save its execution time.  The longest running thread
      // will be the time the matmul is considered to have taken.
      long elapsed = -1;
      try {
         for (int t = 0; t < numThreads; t++) {
            threads[t].join();
            if (MM.getThreadTime(t) > elapsed) {
               elapsed = MM.getThreadTime(t);
            }
         }
      }catch(java.lang.InterruptedException e){
         System.out.println(e);
      }

      printArray(N, C, "Final value of C");
      System.out.println( );
      System.out.println("Time in seconds = "+elapsed/1000.0);
   }
}    
