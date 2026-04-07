<?php

namespace Utilities;

class DotEnv
{
    /**
     * The directory where the .env file can be located.
     *
     * @var string
     */
    protected $path;

    public function __construct(string $path)
    {
        if (!file_exists($path)) {
            throw new \InvalidArgumentException(sprintf('%s does not exist', $path));
        }

        $this->path = $path;
    }

    public function load(): array
    {
        $returnEnv = array();

        if (!is_readable($this->path)) {
            throw new \RuntimeException(sprintf('%s file is not readable', $this->path));
        }

        $lines = file($this->path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

        foreach ($lines as $line) {

            $line = trim($line);

            if ($line === "") {
                continue;
            }

            if (strpos($line, '#') === 0) {
                continue;
            }

            $parts = explode("=", $line, 2);

            if (count($parts) < 2) {
                continue;
            }

            $name = trim($parts[0]);
            $value = trim($parts[1]);

            if ($name === "") {
                continue;
            }

            if (!array_key_exists($name, $_SERVER) && !array_key_exists($name, $_ENV)) {
                putenv(sprintf("%s=%s", $name, $value));
                $_ENV[$name] = $value;
                $_SERVER[$name] = $value;
            }

            $returnEnv[$name] = $value;
        }

        return $returnEnv;
    }
}
?>