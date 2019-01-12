<?php

namespace Assets\Database;

use Exceptions\Implementation\DatabaseException;
use mysqli;
use Utilities\System\IniFileParser;

final class DatabaseConnectionLinkProvider
{
    private static $instance;

    private $connectionSettings;

    public static function getInstance(): DatabaseConnectionLinkProvider
    {
        if (self::$instance === null)
        {
            return (self::$instance = new self());
        }
        else
        {
            return self::$instance;
        }
    }

    public function getConnectionLink(): mysqli
    {
        $connectionLink = mysqli_connect
        (
            $this->connectionSettings['ServerAddress'],
            $this->connectionSettings['Username'],
            $this->connectionSettings['Password'],
            $this->connectionSettings['DatabaseName']
        );
        if (mysqli_connect_errno() === 0)
        {
            return $connectionLink;
        }
        else
        {
            throw new DatabaseException('Failed to connect to database');
        }
    }

    private function __construct()
    {
        $this->connectionSettings = IniFileParser::getInstance()->getSpecifiedIniFile('Master')['DatabaseConnection'];
    }
}