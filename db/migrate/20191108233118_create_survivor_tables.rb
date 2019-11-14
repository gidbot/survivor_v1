class CreateSurvivorTables < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues, force: :cascade  do |t|
      t.string "name", null: false
      t.integer "max_players", null: false, default: 12
      t.string "group_password"
      t.integer "commissioner_id", null: false
      t.json "roster_spots"
    end

    create_table :teams, force: :cascade do |t|
      t.integer "league_id",  null: false, index: true
      t.integer "user_id",    null: false, index: true
      t.string "name", null: false
      t.integer "season_score", default: 0, null: false
      t.index ["user_id", "league_id"], unique: true
    end

    create_table :players, force: :cascade do |t|
      t.string    "name",       null: false
      t.integer   "position",   null: false
      t.string    "team",       null: false
      t.integer   "number",     null: false
    end

    create_table :rosters, force: :cascade do |t|
      t.integer "week_id",         null: false, index: true
      t.integer "team_id",         null: false, index: true
      t.integer "score",           null: false, default: 0
      t.json "roster_spots", null: false
      t.index ["team_id", "week_id"], unique: true
    end

    create_table :weeks, force: :cascade do |t|
      t.integer "number", null: false, index: true
      t.boolean "current", null: false, default: false
      t.index ["number"], where: "current = TRUE"
    end

    create_table :position_players_stats, force: :cascade do |t|
      t.integer "player_id", null: false
      t.integer "week_id", null: false
      t.integer "pass_yards", default: 0
      t.integer "pass_tds", default: 0
      t.integer "interceptions", default: 0
      t.integer "rush_yards", default: 0
      t.integer "rush_tds", default: 0
      t.integer "receptions", default: 0
      t.integer "rec_yards", default: 0
      t.integer "rec_tds", default: 0
      t.integer "return_tds", default: 0
      t.integer "other_tds", default: 0
      t.integer "two_points", default: 0
      t.integer "fumbles_lost", default: 0
      t.index ["player_id", "week_id"], unique: true
    end

    create_table :kickers_stats, force: :cascade do |t|
      t.integer "player_id", null: false, index: true
      t.integer "week_id", null: false, index: true
      t.integer "inside_20", default: 0
      t.integer "twenties", default: 0
      t.integer "thirties", default: 0
      t.integer "fourties", default: 0
      t.integer "over_50", default: 0
      t.integer "pat", default: 0
      t.integer "missed", default: 0
      t.index ["player_id", "week_id"], unique: true
    end

    create_table :defenses_stats, force: :cascade do |t|
      t.integer "player_id", null: false, index: true
      t.integer "week_id", null: false, index: true
      t.integer "sacks", default: 0
      t.integer "interceptions", default: 0
      t.integer "fumble_recoveries", default: 0
      t.integer "touchdowns", default: 0
      t.integer "safeties", default: 0
      t.integer "blocked_kicks", default: 0
      t.integer "return_tds", default: 0
      t.integer "points_allowed", default: 0
      t.index ["player_id", "week_id"], unique: true
    end
  end
end