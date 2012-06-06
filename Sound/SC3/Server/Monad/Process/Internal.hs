module Sound.SC3.Server.Monad.Process.Internal (
    withInternal
  , withDefaultInternal
  -- * Re-exported for convenience
  , module Sound.SC3.Server.Process.Options
  , OutputHandler(..)
  , defaultOutputHandler
) where

import qualified Sound.SC3.Server.Connection as Conn
import           Sound.SC3.Server.Monad (Server)
import qualified Sound.SC3.Server.Monad as Server
import           Sound.SC3.Server.Process (OutputHandler(..), defaultOutputHandler)
import qualified Sound.SC3.Server.Process.Internal as Process
import           Sound.SC3.Server.Process.Options

withInternal :: ServerOptions -> RTOptions -> OutputHandler -> Server a -> IO a
withInternal serverOptions rtOptions outputHandler action =
    Process.withInternal
        serverOptions
        rtOptions
        outputHandler
        $ \t -> Conn.open t >>= Server.runServer action serverOptions

withDefaultInternal :: Server a -> IO a
withDefaultInternal = withInternal defaultServerOptions defaultRTOptions defaultOutputHandler
