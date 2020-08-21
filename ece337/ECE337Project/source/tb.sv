`timescale 1ns / 1ps

module tb();

    reg [7:0] A; //register declaration for storing each line of file.
    integer outfile; //file descriptors

initial begin
    
    //The $fopen function opens a file and returns a multi-channel descriptor 
    //in the format of an unsized integer. 
    outfile=$fopen("A_hex.txt","r");   //"r" means reading and "w" means writing
    
    //read the contents of the file A_hex.txt as hexadecimal values into register "A".
    while (! $feof(outfile)) begin //read until an "end of file" is reached.
        $fscanf(outfile,"%d\n",A); //scan each line and get the value as an hexadecimal
    //Write the read value into text files.
        $fdisplay(outfile,"%d",A); //write as decimal
        #10;
    end 
    //once reading and writing is finished, close all the files.
    $fclose(outfile);
    //wait and then stop the simulation.
    #100;
    $stop;
end    
      
endmodule

