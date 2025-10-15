permissionset 50103 "VI Creation Permissions"
{
    Caption = 'VI Creation Permissions';
    Assignable = false;

    Permissions =
        tabledata CategorieClient = RIMD,
        tabledata "Customer Email Log" = RIMD,
        tabledata RelationType = RIMD,
        tabledata SecteurActivite = RIMD;
}