{-# LANGUAGE MultiWayIf #-}

module Rcm.Lsrc where

import Control.Monad (forM_)
import System.Environment (getArgs, getEnv)
import Rcm.Private.Lsrc
import Rcm.Private.Data
import Rcm.Private.Dotfiles (getDotfiles, Dotfile(..))

main = do
  args <- getArgs
  homedir <- getEnv "HOME"
  let c = defaultConfig homedir
      (config,files) = parseArgs c args

  putStrLn "Config:"
  print config
  putStrLn "Files:"
  print files

  dotfiles <- getDotfiles config files

  forM_ dotfiles $ \dotfile ->
    putStrLn $ (dotfileSource dotfile) ++ ":" ++ (dotfileTarget dotfile)

  return ()