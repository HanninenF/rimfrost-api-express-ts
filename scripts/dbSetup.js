import { execSync } from "child_process";
import "dotenv/config";

const { DB_HOST, DB_PORT, DB_USER, DB_PASS, DB_NAME } = process.env;

const base = `mysql --protocol=tcp -h ${DB_HOST} -P ${DB_PORT} -u ${DB_USER}`;

const run = (cmd) => {
  console.log(`\n▶ ${cmd}`);
  execSync(cmd, {
    stdio: "inherit",
    env: { ...process.env, MYSQL_PWD: DB_PASS },
  });
};

run(`${base} < src/db/sql/migrations/001_init_schema.sql`);
run(
  `${base} ${DB_NAME} < src/db/sql/migrations/002_base_data_roles_formats.sql`
);
run(
  `${base} ${DB_NAME} < src/db/sql/migrations/003_seed_people_records_songs.sql`
);
run(
  `${base} ${DB_NAME} < src/db/sql/migrations/004_relations_release_credit.sql`
);
run(`${base} ${DB_NAME} < src/db/sql/migrations/005_relations_song_writer.sql`);
run(`${base} ${DB_NAME} < src/db/sql/migrations/006_seed_song_writer_role.sql`);
run(`${base} ${DB_NAME} < src/db/sql/migrations/007_seed_tracklist.sql`);
run(`${base} ${DB_NAME} < src/db/sql/migrations/008_seed_editions.sql`);
