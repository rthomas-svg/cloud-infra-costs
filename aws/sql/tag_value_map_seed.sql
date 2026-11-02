-- SDP-4202: seed governance.aws.tag_value_map (rerunnable)
-- current_value is stored lowercase/trimmed; consumers match on lower(trim(raw_value)).
MERGE INTO governance.aws.tag_value_map AS t
USING (
  SELECT * FROM VALUES
    ('product', 'bi', 'businesssystems', NULL),
    ('product', 'business-intelligence', 'businesssystems', NULL),
    ('product', 'business_intelligence', 'businesssystems', NULL),
    ('product', 'commerce', 'commerce', NULL),
    ('product', 'compliance', 'compliance', 'Own product for now'),
    ('product', 'core', 'dataplatform', NULL),
    ('product', 'data', 'dataplatform', NULL),
    ('product', 'data-delivery', 'dataplatform', NULL),
    ('product', 'data-platform', 'dataplatform', NULL),
    ('product', 'data-product', 'dataplatform', 'Assumed dataplatform'),
    ('product', 'data-science', 'datascience', NULL),
    ('product', 'data_sales', 'commerce', 'Open decision 2 on SDP-4201: data_sales maps to commerce'),
    ('product', 'dataplatform', 'dataplatform', NULL),
    ('product', 'exchange', 'exchange', NULL),
    ('product', 'genie-poc', 'dataplatform', 'Assumed dataplatform'),
    ('product', 'internal-reporting-user', 'businesssystems', NULL),
    ('product', 'looker', 'businesssystems', 'Assumed businesssystems'),
    ('product', 'metrics', 'dataplatform', NULL),
    ('product', 'mobile', NULL, 'Pending open decision 2 on SDP-4201'),
    ('product', 'monitoring', 'dataplatform', NULL),
    ('product', 'testing', 'dataplatform', 'Assumed dataplatform'),
    ('application', 'audit logging load', 'audit-logging-load', 'snake_case/spaces to kebab-case'),
    ('application', 'bi team shared cluster', 'bi-shared-cluster', 'Per SDP-4202'),
    ('application', 'data delivery', 'data-delivery', 'snake_case/spaces to kebab-case'),
    ('application', 'dataplatform_signal_core', 'dataplatform-signal-core', 'snake_case/spaces to kebab-case'),
    ('application', 'deals_forecasting', 'deals-forecasting', 'snake_case/spaces to kebab-case'),
    ('application', 'dimensional_creative_dimension_hourly_rollup', 'dimensional-creative-dimension-hourly-rollup', 'snake_case/spaces to kebab-case'),
    ('application', 'dimensional_dim_cleanup_hourly', 'dimensional-dim-cleanup-hourly', 'snake_case/spaces to kebab-case'),
    ('application', 'dimensional_geo_info_hourly_rollup', 'dimensional-geo-info-hourly-rollup', 'snake_case/spaces to kebab-case'),
    ('application', 'dimensional_reader_ua_hourly_rollup', 'dimensional-reader-ua-hourly-rollup', 'snake_case/spaces to kebab-case'),
    ('application', 'dlt streaming - exchange', 'dlt-streaming-exchange', 'snake_case/spaces to kebab-case'),
    ('application', 'exchange_streaming_retention_ttl', 'exchange-streaming-retention-ttl', 'snake_case/spaces to kebab-case'),
    ('application', 'import_mysql_addb_data', 'import-mysql-addb-data', 'snake_case/spaces to kebab-case'),
    ('application', 'jounce', 'jounces-ingestion', 'Duplicate of jounces-ingestion'),
    ('application', 'network_quality_app_bundle_reviews', 'network-quality-app-bundle-reviews', 'snake_case/spaces to kebab-case'),
    ('application', 'sql warehouse', 'sql-warehouse', 'snake_case/spaces to kebab-case'),
    ('application', 'supply and demand', 'supply-and-demand', 'snake_case/spaces to kebab-case'),
    ('application', 'tapad hem', 'tapad-hem', 'snake_case/spaces to kebab-case'),
    ('application', 'traffic shaping', 'traffic-shaping', 'snake_case/spaces to kebab-case'),
    ('application', 'traffic_shaping_outbound', 'traffic-shaping-outbound', 'snake_case/spaces to kebab-case'),
    ('application', 'update_datedimension_table', 'update-datedimension-table', 'snake_case/spaces to kebab-case'),
    ('application', 'xsp deals - export to table', 'xsp-deals-export-to-table', 'snake_case/spaces to kebab-case'),
    ('product', 'commerce-audiences', NULL, 'Only seen in CUR 2026-07; mapping not yet decided'),
    ('product', 'deals', NULL, 'Only seen in CUR 2026-07; mapping not yet decided'),
    ('product', 'hem', NULL, 'Only seen in CUR 2026-07; mapping not yet decided'),
    ('product', 'weblog', NULL, 'Only seen in CUR 2026-07; mapping not yet decided'),
    ('product', 'weblog-gdpr', NULL, 'Only seen in CUR 2026-07; mapping not yet decided')
  AS s(tag_key, current_value, standard_value, notes)
) AS s
ON t.tag_key = s.tag_key AND t.current_value = s.current_value
WHEN MATCHED THEN UPDATE SET t.standard_value = s.standard_value, t.notes = s.notes
WHEN NOT MATCHED THEN INSERT *;
