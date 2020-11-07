default: channels.csv

channels.csv: channels.txt
	python3 baofeng-csv.py channels.txt > channels.csv

clean:
	rm -f channels.csv
