import sys
import pandas as pd
import json

input_file = sys.argv[1]
output_file = sys.argv[2]
summary_file = sys.argv[3]

try:
    df = pd.read_csv(input_file)

    # Clean data (example)
    df = df.dropna()

    # Filter example (sepal_length > 5)
    filtered = df[df["sepal_length"] > 5]

    # Save filtered CSV
    filtered.to_csv(output_file, index=False)

    # Summary
    summary = {
        "total_rows": len(df),
        "filtered_rows": len(filtered),
        "columns": list(df.columns)
    }

    with open(summary_file, "w") as f:
        json.dump(summary, f, indent=4)

    print("Processing completed successfully")

except Exception as e:
    print(f"Error: {e}")
    sys.exit(1)
