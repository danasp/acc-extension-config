require 'utils'
require 'fireworks_base'
require 'fireworks_spawn'
require 'fireworks_colors'
require 'fireworks_audio'
require 'fireworks_types'
require 'fireworks_pyro'

local pyros = {}
for i = 1, ac.getFireworksSpotCount() do
  pyros[#pyros + 1] = Pyro:new{ pos = ac.getFireworksSpot(i - 1), sourceIndex = i - 1 }
end
local pyrosSize = #pyros

function update(dt, intensity)
  audioPoolPrepare(dt)
  
  local piecesSize = #piecesList
  for i = piecesSize, 1, -1 do
    if not piecesList[i]:updateBase(dt) then
      table.remove(piecesList, i)
    end
  end

  local allowToSpawn = intensity > 0 and piecesSize < 50
  for i = 1, pyrosSize do
    pyros[i]:update(dt, allowToSpawn, intensity)
  end

  ac.debug('items', piecesSize)
  ac.debug('intensity', intensity)

  -- runGC()
end