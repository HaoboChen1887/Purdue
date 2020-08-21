pdf_cnt=0
for files in ./myDir/*.pdf
do
    if [[ $files != "./myDir/*.pdf" ]]
    then
        echo $files
        let pdf_cnt=pdf_cnt+1
    fi
done
echo "Number of pdf files: $pdf_cnt"

num_l=5
head -n${num_l} "data.txt" | tail -n1

userinput.o < input.txt

if [[ $(diff foo1.txt foo2.txt) ]]
then
    echo "Files are different"
else
    echo "Files are similar"
fi



