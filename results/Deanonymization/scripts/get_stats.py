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

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} <file.txt> <N_runs>")
    else:
        file_path = sys.argv[1]
        num_lines = count_lines_in_file(file_path)
        num_runs = int(sys.argv[2])
        print("Runs {r}, Successes {s}. Success Rate {sr}%".format(r=num_runs, s=num_lines, sr=(num_lines/num_runs)*100))
        
