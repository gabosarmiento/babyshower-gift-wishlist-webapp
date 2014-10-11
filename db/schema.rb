# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141011103028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "compromisos", force: true do |t|
    t.integer  "user_id"
    t.integer  "regalo_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "compromisos", ["regalo_id"], name: "index_compromisos_on_regalo_id", using: :btree
  add_index "compromisos", ["user_id"], name: "index_compromisos_on_user_id", using: :btree

  create_table "convidados", force: true do |t|
    t.string   "email"
    t.integer  "anfitrion_id"
    t.integer  "invitado_id"
    t.string   "token"
    t.integer  "fiesta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "asistencia"
  end

  add_index "convidados", ["fiesta_id"], name: "index_convidados_on_fiesta_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "fiestas", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "fecha_y_hora_inicio"
    t.string   "fecha_y_hora_cierre"
    t.string   "lugar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_contacto"
    t.string   "telefono_contacto"
    t.string   "slug"
    t.string   "fecha_y_hora_cierre_rsvps"
    t.string   "cover"
  end

  add_index "fiestas", ["slug"], name: "index_fiestas_on_slug", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "listas", force: true do |t|
    t.string   "nombre"
    t.integer  "fiesta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "listas", ["fiesta_id"], name: "index_listas_on_fiesta_id", using: :btree
  add_index "listas", ["slug"], name: "index_listas_on_slug", using: :btree

  create_table "regalos", force: true do |t|
    t.string   "titulo"
    t.string   "imagen"
    t.string   "url"
    t.integer  "lista_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "donde_lo_consigues"
    t.integer  "position"
    t.text     "descripcion"
  end

  add_index "regalos", ["lista_id"], name: "index_regalos_on_lista_id", using: :btree

  create_table "rsvps", force: true do |t|
    t.integer  "user_id"
    t.integer  "fiesta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rsvps", ["fiesta_id"], name: "index_rsvps_on_fiesta_id", using: :btree
  add_index "rsvps", ["user_id"], name: "index_rsvps_on_user_id", using: :btree

  create_table "tiendas", force: true do |t|
    t.string   "nombre"
    t.string   "locacion"
    t.string   "url"
    t.text     "acerca_de"
    t.boolean  "pagos_online"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
