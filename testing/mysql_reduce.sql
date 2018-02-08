SET foreign_key_checks = 0;
DROP TABLE IF EXISTS algorithm;
DROP TABLE IF EXISTS algorithm_quality;
DROP TABLE IF EXISTS algorithm_setup;
DROP TABLE IF EXISTS awarded_badges;
DROP TABLE IF EXISTS bibliographical_reference;
DROP TABLE IF EXISTS data_feature;
DROP TABLE IF EXISTS data_processed;
DROP TABLE IF EXISTS data_quality;
DROP TABLE IF EXISTS data_quality_interval;
DROP TABLE IF EXISTS dataset;
DROP TABLE IF EXISTS dataset_tag;
DROP TABLE IF EXISTS downloads;
DROP TABLE IF EXISTS downvote_reasons;
DROP TABLE IF EXISTS downvotes;
DROP TABLE IF EXISTS estimation_procedure;
DROP TABLE IF EXISTS estimation_procedure_type;
DROP TABLE IF EXISTS evaluation_engine;
DROP TABLE IF EXISTS feature_quality;
DROP TABLE IF EXISTS implementation_component;
DROP TABLE IF EXISTS implementation_tag;
DROP TABLE IF EXISTS input_data;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS math_function;
DROP TABLE IF EXISTS notebook;
DROP TABLE IF EXISTS old_dataset_table;
DROP TABLE IF EXISTS output_data;
DROP TABLE IF EXISTS pdnresults;
DROP TABLE IF EXISTS quality;
DROP TABLE IF EXISTS run_evaluated;
DROP TABLE IF EXISTS run_tag;
DROP TABLE IF EXISTS runfile;
DROP TABLE IF EXISTS schedule;
DROP TABLE IF EXISTS setup_differences;
DROP TABLE IF EXISTS setup_tag;
DROP TABLE IF EXISTS study;
DROP TABLE IF EXISTS study_tag;
DROP TABLE IF EXISTS trace;
DROP TABLE IF EXISTS task_inputs;
DROP TABLE IF EXISTS task_io_types;
DROP TABLE IF EXISTS task_tag;
DROP TABLE IF EXISTS task_type;
DROP TABLE IF EXISTS task_type_inout;
SET foreign_key_checks = 1;

DELETE FROM run WHERE uploader <> 2702;
