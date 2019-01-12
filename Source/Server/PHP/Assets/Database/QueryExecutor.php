<?php

namespace Assets\Database;

use Exceptions\Implementation\DatabaseException;
use mysqli;
use mysqli_result;

class QueryExecutor
{
    private function closeMysqli(mysqli $connectionLink): void
    {
        if (mysqli_close($connectionLink) === false)
        {
            throw new DatabaseException('Failed to close the connection');
        }
    }

    public function executeQuery(string $queryString): ?array
    {
        $connectionLink = DatabaseConnectionLinkProvider::getInstance()->getConnectionLink();
        $queryResult = mysqli_query($connectionLink, $queryString);
        try
        {
            if ($queryResult instanceof mysqli_result)
            {
                $this->closeMysqli($connectionLink);
                return $queryResult->fetch_assoc();
            }
            elseif ($queryResult === true)
            {
                $this->closeMysqli($connectionLink);
                return array('QueryResult' => true);
            }
            else
            {
                throw new DatabaseException('Query execution failed');
            }
        }
        finally
        {
            unset($connectionLink);
            unset($queryResult);
        }
    }
}