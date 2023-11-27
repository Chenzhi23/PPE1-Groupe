#!/bin/bash

lineno=1

# Check if the file containing URLs exists
if [ ! -f "$1" ]; then
  echo "Error: File '$1' does not exist."
  exit 1
fi

# Start of the HTML document
echo "<html>
  <head>
    <meta charset=\"UTF-8\">
  </head>
<body>
  <table>
    <tr><th>ligne</th><th>URL</th><th>code HTTP</th><th>encodage</th></tr>"

# Process each URL
while read -r URL; do
  # Get the HTTP status code
  status=$(curl -o /dev/null -s -w "%{http_code}" "$URL")
  # Get the headers and extract the content type
  encoding=$(curl -I -s "$URL" | grep -i "Content-Type:" | awk -F'charset=' '{print $2}' | tr -d '[\r\n]')
  
  # Output each table row
  echo "<tr>
          <td>$lineno</td>
          <td>$URL</td>
          <td>$status</td>
          <td>$encoding</td>
        </tr>"
  
  lineno=$((lineno + 1))
done < "$1"

# End of the HTML document
echo "</table>
</body>
</html>"
