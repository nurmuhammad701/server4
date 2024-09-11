package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func main() {
	// Server1 ga ulanish
	db1, err := sql.Open("postgres", "host=your_local_ip port=5432 user=postgres password=your_password dbname=server1_db sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	defer db1.Close()

	// Server2 ga ulanish
	db2, err := sql.Open("postgres", "host=your_local_ip port=5433 user=postgres password=your_password dbname=server2_db sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	defer db2.Close()

	// Server3 ga ulanish
	db3, err := sql.Open("postgres", "host=your_local_ip port=5434 user=postgres password=your_password dbname=server3_db sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	defer db3.Close()

	// Server4 ga ulanish (masofaviy)
	db4, err := sql.Open("postgres", "host=localhost port=5432 user=postgres password=your_password dbname=server4_db sslmode=disable")
	if err != nil {
		log.Fatal(err)
	}
	defer db4.Close()

	// Barcha serverlardan ma'lumotlarni o'qish
	servers := []struct {
		name string
		db   *sql.DB
	}{
		{"Server1", db1},
		{"Server2", db2},
		{"Server3", db3},
		{"Server4", db4},
	}

	for _, server := range servers {
		fmt.Printf("Users from %s:\n", server.name)
		rows, err := server.db.Query("SELECT * FROM users")
		if err != nil {
			log.Printf("Error querying %s: %v", server.name, err)
			continue
		}
		defer rows.Close()

		for rows.Next() {
			var id int
			var username, email string
			if err := rows.Scan(&id, &username, &email); err != nil {
				log.Printf("Error scanning row from %s: %v", server.name, err)
				continue
			}
			fmt.Printf("ID: %d, Username: %s, Email: %s\n", id, username, email)
		}
		fmt.Println()
	}
}
