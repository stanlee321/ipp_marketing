CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE TABLE "item" (
  "id" serial4 NOT NULL,
  "created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "is_deleted" bool NOT NULL DEFAULT false,
  "uuid" uuid NOT NULL DEFAULT (uuid_generate_v4()),
  "category" varchar(255) NOT NULL,
  "name" varchar(255) NOT NULL,
  "description" varchar(5000),
  "price" float8 NOT NULL,
  "quantity" int8 NOT NULL,
  "image" varchar(1000),
  PRIMARY KEY ("id")
);

CREATE TABLE "user" (
  "id" serial4 NOT NULL,
  "created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "is_deleted" bool NOT NULL DEFAULT false,
  "uuid" uuid NOT NULL DEFAULT (uuid_generate_v4()),
  "first_name" varchar(255) NOT NULL,
  "last_name" varchar(255) NOT NULL,
  "email" varchar(255) NOT NULL,
  "role" varchar(20) NOT NULL,
  "status" varchar(20) NOT NULL,
  "password_hash" varchar(255) NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "customer_cart" (
  "id" serial4 NOT NULL,
  "created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "is_deleted" bool NOT NULL DEFAULT false,
  "uuid" uuid NOT NULL DEFAULT (uuid_generate_v4()),
  "customer_id" int4 NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "cart_item" (
  "id" serial4 NOT NULL,
  "created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "is_deleted" bool NOT NULL DEFAULT false,
  "uuid" uuid NOT NULL DEFAULT (uuid_generate_v4()),
  "item_id" int4 NOT NULL,
  "cart_id" int4 NOT NULL,
  "quantity_in_cart" int8 NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "profiles" (
  "id" serial4 NOT NULL,
  "created_at" timestamptz,
  "updated_at" timestamptz DEFAULT (now()),
  "is_deleted" bool DEFAULT false,
  "uuid" uuid NOT NULL DEFAULT (uuid_generate_v4()),
  "name" varchar(1000) ,
  "role" varchar,
  "location" varchar(255),
  "connection" varchar(255),
  "services" varchar(600),
  "profile_url" varchar(600),
  "page" int4 NOT NULL,
  "status" varchar(20) NOT NULL,
  "search_url" varchar,


  "location_work" varchar,
  "business_name_main" varchar,
  "business_name_secondary" varchar,
  "website"  varchar,
  "email" varchar(100),
  "phone" varchar(100),
  "whatsapp" varchar(100),

  "message_type" varchar(255),
  "ci_intro_ippb" varchar(255),
  "ci_staff_aug" varchar(255),
  "ci_gestion_datos" varchar(255),
  "ci_nkt_medio" varchar(255),
  "medio" varchar(255),
  "send_by" varchar(255),
  "linkedin_status" varchar(255),

  PRIMARY KEY ("id")
);

CREATE TABLE "messages" (
  "id" serial4 NOT NULL,
  "created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "is_deleted" bool NOT NULL DEFAULT false,
  "uuid" uuid NOT NULL DEFAULT (uuid_generate_v4()),
  "profile_id"  int4,
  "message" varchar(255),
  PRIMARY KEY ("id")
);

CREATE TABLE "message_profiles" (
  "message_id" serial4 ,
  "profile_id" serial4 
);



CREATE TABLE "tasks" (
  "id" serial4 NOT NULL,
  "created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL DEFAULT (now()),
  "is_deleted" bool NOT NULL DEFAULT false,
  "task_status"  varchar(20), -- RUNNING, FINISHED, STUCK
  "task_type"  varchar(20), -- SCRAPING, MESSAGING
  "created_by"  int4,
  PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "item_un" ON "item" ("uuid");

CREATE UNIQUE INDEX "user_un" ON "user" ("uuid");

CREATE UNIQUE INDEX "user_unique_email" ON "user" ("email");

CREATE UNIQUE INDEX "customer_cart_un" ON "customer_cart" ("uuid");

CREATE UNIQUE INDEX "cart_item_un" ON "cart_item" ("uuid");

CREATE UNIQUE INDEX "profiles_un" ON "profiles" ("uuid");

CREATE UNIQUE INDEX "messages_un" ON "messages" ("uuid");

ALTER TABLE "message_profiles" ADD FOREIGN KEY ("message_id") REFERENCES "messages" ("id");

ALTER TABLE "message_profiles" ADD FOREIGN KEY ("profile_id") REFERENCES "profiles" ("id");

ALTER TABLE "messages" ADD FOREIGN KEY ("profile_id") REFERENCES "profiles" ("id");

ALTER TABLE "customer_cart" ADD CONSTRAINT "customer_cart_fk" FOREIGN KEY ("customer_id") REFERENCES "user" ("id");

ALTER TABLE "cart_item" ADD CONSTRAINT "cart_item_fk" FOREIGN KEY ("cart_id") REFERENCES "customer_cart" ("id");

ALTER TABLE "cart_item" ADD CONSTRAINT "cart_item_fk_1" FOREIGN KEY ("item_id") REFERENCES "item" ("id");
