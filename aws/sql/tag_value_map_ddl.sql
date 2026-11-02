-- SDP-4202: tag_value_map (rerunnable)
-- current_value is stored lowercase/trimmed; consumers match on lower(trim(raw_value)).
CREATE TABLE IF NOT EXISTS governance.aws.tag_value_map (
  tag_key        STRING NOT NULL COMMENT 'Tag key being standardized: product or application',
  current_value  STRING NOT NULL COMMENT 'Raw tag value, lowercased and trimmed',
  standard_value STRING          COMMENT 'Approved value per the AWS Resource Tagging Standard; NULL = decision pending',
  notes          STRING          COMMENT 'Why the mapping exists or what it is waiting on',
  CONSTRAINT tag_value_map_pk PRIMARY KEY (tag_key, current_value) NOT ENFORCED
)
COMMENT 'Maps current Databricks/AWS tag values to the approved standard for cost reporting (SDP-4202, epic SDP-4201)';

ALTER TABLE governance.aws.tag_value_map ADD CONSTRAINT tag_key_valid CHECK (tag_key IN ('product', 'application'));
ALTER TABLE governance.aws.tag_value_map ADD CONSTRAINT standard_value_format CHECK (standard_value IS NULL OR standard_value RLIKE '^[a-z0-9]+(-[a-z0-9]+)*$');
