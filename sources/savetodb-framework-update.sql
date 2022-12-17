-- =============================================
-- SaveToDB Framework for Snowflake
-- Version 10.6, December 13, 2022
--
-- This script updates SaveToDB Framework 10 to the latest version
--
-- Copyright 2018-2022 Gartle LLC
--
-- License: MIT
-- =============================================

SELECT CASE WHEN 1006 <= CAST(SUBSTR(HANDLER_CODE, 1, POSITION('.' IN HANDLER_CODE) - 1) AS INT) * 100 + CAST(SUBSTR(HANDLER_CODE, POSITION('.' IN HANDLER_CODE) + 1) AS DECIMAL) THEN 'SaveToDB Framework is up-to-date. Update skipped' ELSE HANDLER_CODE END AS CHECK_VERSION FROM XLS.HANDLERS WHERE TABLE_SCHEMA = 'XLS' AND TABLE_NAME = 'SAVETODB_FRAMEWORK' AND COLUMN_NAME = 'VERSION' AND EVENT_NAME = 'Information' LIMIT 1;

UPDATE XLS.HANDLERS t
SET
    HANDLER_CODE = s.HANDLER_CODE
    , TARGET_WORKSHEET = s.TARGET_WORKSHEET
    , MENU_ORDER = s.MENU_ORDER
    , EDIT_PARAMETERS = s.EDIT_PARAMETERS
FROM
    (
    SELECT
        CAST(NULL AS varchar) AS TABLE_SCHEMA
        , CAST(NULL AS varchar) AS TABLE_NAME
        , CAST(NULL AS varchar) AS COLUMN_NAME
        , CAST(NULL AS varchar) AS EVENT_NAME
        , CAST(NULL AS varchar) AS HANDLER_SCHEMA
        , CAST(NULL AS varchar) AS HANDLER_NAME
        , CAST(NULL AS varchar) AS HANDLER_TYPE
        , CAST(NULL AS varchar) HANDLER_CODE
        , CAST(NULL AS varchar) AS TARGET_WORKSHEET
        , CAST(NULL AS int) AS MENU_ORDER
        , CAST(NULL AS boolean) AS EDIT_PARAMETERS

    UNION ALL SELECT 'XLS', 'SAVETODB_FRAMEWORK', 'VERSION', 'Information', NULL, NULL, 'ATTRIBUTE', '10.6', NULL, NULL, NULL
    UNION ALL SELECT 'XLS', 'HANDLERS', 'EVENT_NAME', 'ValidationList', NULL, NULL, 'VALUES', 'Actions, AddHyperlinks, AddStateColumn, Authentication, BitColumn, Change, ContextMenu, ConvertFormulas, DataTypeBit, DataTypeBoolean, DataTypeDate, DataTypeDateTime, DataTypeDateTimeOffset, DataTypeDouble, DataTypeInt, DataTypeGuid, DataTypeString, DataTypeTime, DataTypeTimeSpan, DefaultListObject, DefaultValue, DependsOn, DoNotAddChangeHandler, DoNotAddDependsOn, DoNotAddManyToMany, DoNotAddValidation, DoNotChange, DoNotConvertFormulas, DoNotKeepComments, DoNotKeepFormulas, DoNotSave, DoNotSelect, DoNotSort, DoNotTranslate, DoubleClick, DynamicColumns, Format, Formula, FormulaValue, Information, JsonForm, KeepFormulas, KeepComments, License, LoadFormat, ManyToMany, ParameterValues, ProtectRows, RegEx, SaveFormat, SaveWithoutTransaction, SelectionChange, SelectionList, SelectPeriod, SyncParameter, UpdateChangedCellsOnly, UpdateEntireRow, ValidationList', NULL, NULL, NULL

    ) s
WHERE
    s.TABLE_NAME IS NOT NULL
    AND t.TABLE_SCHEMA = s.TABLE_SCHEMA
    AND t.TABLE_NAME = s.TABLE_NAME
    AND COALESCE(t.COLUMN_NAME, '') = COALESCE(s.COLUMN_NAME, '')
    AND t.EVENT_NAME = s.EVENT_NAME
    AND COALESCE(t.HANDLER_SCHEMA, '') = COALESCE(s.HANDLER_SCHEMA, '')
    AND COALESCE(t.HANDLER_NAME, '') = COALESCE(s.HANDLER_NAME, '')
    AND COALESCE(t.HANDLER_TYPE, '') = COALESCE(s.HANDLER_TYPE, '')
    AND (
    NOT COALESCE(t.HANDLER_CODE, '') = COALESCE(s.HANDLER_CODE, '')
    OR NOT COALESCE(t.TARGET_WORKSHEET, '') = COALESCE(s.TARGET_WORKSHEET, '')
    OR NOT COALESCE(t.MENU_ORDER, -1) = COALESCE(s.MENU_ORDER, -1)
    OR NOT COALESCE(t.EDIT_PARAMETERS, 0) = COALESCE(s.EDIT_PARAMETERS, 0)
    );

INSERT INTO XLS.HANDLERS
    ( TABLE_SCHEMA
    , TABLE_NAME
    , COLUMN_NAME
    , EVENT_NAME
    , HANDLER_SCHEMA
    , HANDLER_NAME
    , HANDLER_TYPE
    , HANDLER_CODE
    , TARGET_WORKSHEET
    , MENU_ORDER
    , EDIT_PARAMETERS
    )
SELECT
    s.TABLE_SCHEMA
    , s.TABLE_NAME
    , s.COLUMN_NAME
    , s.EVENT_NAME
    , s.HANDLER_SCHEMA
    , s.HANDLER_NAME
    , s.HANDLER_TYPE
    , s.HANDLER_CODE
    , s.TARGET_WORKSHEET
    , s.MENU_ORDER
    , s.EDIT_PARAMETERS
FROM
    (
    SELECT
        CAST(NULL AS varchar) AS TABLE_SCHEMA
        , CAST(NULL AS varchar) AS TABLE_NAME
        , CAST(NULL AS varchar) AS COLUMN_NAME
        , CAST(NULL AS varchar) AS EVENT_NAME
        , CAST(NULL AS varchar) AS HANDLER_SCHEMA
        , CAST(NULL AS varchar) AS HANDLER_NAME
        , CAST(NULL AS varchar) AS HANDLER_TYPE
        , CAST(NULL AS varchar) HANDLER_CODE
        , CAST(NULL AS varchar) AS TARGET_WORKSHEET
        , CAST(NULL AS int) AS MENU_ORDER
        , CAST(NULL AS boolean) AS EDIT_PARAMETERS

    UNION ALL SELECT 'XLS', 'SAVETODB_FRAMEWORK', 'VERSION', 'Information', NULL, NULL, 'ATTRIBUTE', '10.6', NULL, NULL, NULL
    UNION ALL SELECT 'XLS', 'HANDLERS', 'EVENT_NAME', 'ValidationList', NULL, NULL, 'VALUES', 'Actions, AddHyperlinks, AddStateColumn, Authentication, BitColumn, Change, ContextMenu, ConvertFormulas, DataTypeBit, DataTypeBoolean, DataTypeDate, DataTypeDateTime, DataTypeDateTimeOffset, DataTypeDouble, DataTypeInt, DataTypeGuid, DataTypeString, DataTypeTime, DataTypeTimeSpan, DefaultListObject, DefaultValue, DependsOn, DoNotAddChangeHandler, DoNotAddDependsOn, DoNotAddManyToMany, DoNotAddValidation, DoNotChange, DoNotConvertFormulas, DoNotKeepComments, DoNotKeepFormulas, DoNotSave, DoNotSelect, DoNotSort, DoNotTranslate, DoubleClick, DynamicColumns, Format, Formula, FormulaValue, Information, JsonForm, KeepFormulas, KeepComments, License, LoadFormat, ManyToMany, ParameterValues, ProtectRows, RegEx, SaveFormat, SaveWithoutTransaction, SelectionChange, SelectionList, SelectPeriod, SyncParameter, UpdateChangedCellsOnly, UpdateEntireRow, ValidationList', NULL, NULL, NULL

    ) s
    LEFT OUTER JOIN XLS.HANDLERS T ON
        t.TABLE_SCHEMA = s.TABLE_SCHEMA
        AND t.TABLE_NAME = s.TABLE_NAME
        AND COALESCE(t.COLUMN_NAME, '') = COALESCE(s.COLUMN_NAME, '')
        AND t.EVENT_NAME = s.EVENT_NAME
        AND COALESCE(t.HANDLER_SCHEMA, '') = COALESCE(s.HANDLER_SCHEMA, '')
        AND COALESCE(t.HANDLER_NAME, '') = COALESCE(s.HANDLER_NAME, '')
        AND COALESCE(t.HANDLER_TYPE, '') = COALESCE(s.HANDLER_TYPE, '')
WHERE
    s.TABLE_NAME IS NOT NULL
    AND t.TABLE_NAME IS NULL;

-- print SaveToDB Framework updated
