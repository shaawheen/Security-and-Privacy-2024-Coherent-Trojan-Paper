import sys

def count_lines_in_file(file_path):
    try:
        with open(file_path, 'r') as file:
            lines = file.readlines()
            num_lines = len(lines)
        return num_lines
    except FileNotFoundError:
        print(f"The file '{file_path}' does not exist.")
        return None

def sum_second_column(file_path):
    total = 0
    with open(file_path, 'r') as file:
        for line in file:
            columns = line.split()
            if len(columns) > 1:  # Ensure there are at least two columns
                total += int(columns[1])
    return total

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} <file.txt> <N_runs>")
    else:
        file_path = sys.argv[1]
        num_lines = count_lines_in_file(file_path)
        sum = sum_second_column(file_path)
        num_runs = int(sys.argv[2])
        print("Runs {r}, Successes {s}. Success Rate {sr}% | Avg Time {t}s".format(r=num_runs, s=num_lines, sr=(num_lines/num_runs)*100, t=sum/num_lines))
        
