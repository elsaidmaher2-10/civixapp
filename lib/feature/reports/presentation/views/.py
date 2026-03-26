
import pandas as pd
import numpy as np

students = pd.DataFrame({
    "ID":   [1, 2, 3, 4],
    "Name": ["Ahmed", "Sara", "Omar", "Mona"],
    "Age":  [21, np.nan, 22, 20]
})

scores = pd.DataFrame({
    "ID":    [1, 2, 3, 4],
    "Score": [90, 85, 88, 92]
})

print('--- Students Records ---')
print(students)

students['Age'] = students['Age'].fillna(students['Age'].median())

final_report = pd.merge(students, scores, on='ID')

print('\n--- Final Integrated Dataset ---')
print(final_report)
