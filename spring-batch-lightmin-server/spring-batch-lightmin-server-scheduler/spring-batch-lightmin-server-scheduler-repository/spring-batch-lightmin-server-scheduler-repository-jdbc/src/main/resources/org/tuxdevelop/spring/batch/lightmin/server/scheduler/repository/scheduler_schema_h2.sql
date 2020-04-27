CREATE TABLE SCHEDULER_CONFIGURATION
(
    id                   NUMERIC IDENTITY PRIMARY KEY NOT NULL,
    application_name     VARCHAR(255) NOT NULL,
    job_name             VARCHAR(255) NOT NULL,
    configuration_status VARCHAR(255) NOT NULL
);

CREATE TABLE SCHEDULER_CONFIGURATION_VALUE
(
    id                         NUMERIC IDENTITY PRIMARY KEY NOT NULL,
    scheduler_configuration_id NUMERIC      NOT NULL,
    type                       VARCHAR(255) NOT NULL,
    value                      VARCHAR(255) NOT NULL,
    FOREIGN KEY (scheduler_configuration_id) REFERENCES SCHEDULER_CONFIGURATION (id)
);

CREATE TABLE SCHEDULER_EXECUTION
(
    id                         NUMERIC IDENTITY PRIMARY KEY NOT NULL,
    scheduler_configuration_id NUMERIC   NOT NULL,
    next_fire_time             TIMESTAMP NOT NULL,
    execution_count            INT       NOT NULL DEFAULT 0,
    state                      INT       NOT NULL,
    FOREIGN KEY (scheduler_configuration_id) REFERENCES SCHEDULER_CONFIGURATION (id)
);

-- INDEX

-- SCHEDULER_CONFIGURATION
CREATE INDEX idx_sc_app_name ON SCHEDULER_CONFIGURATION (application_name);
-- SCHEDULER_EXECUTION
CREATE INDEX idx_se_next_fire_time ON SCHEDULER_EXECUTION (next_fire_time);
CREATE INDEX idx_se_state ON SCHEDULER_EXECUTION (state);
CREATE INDEX idx_se_state_next_fire_time ON SCHEDULER_EXECUTION (state, next_fire_time);
CREATE INDEX idx_se_sc_id ON SCHEDULER_EXECUTION (scheduler_configuration_id);
CREATE INDEX idx_se_sc_id_state ON SCHEDULER_EXECUTION (scheduler_configuration_id, state);



