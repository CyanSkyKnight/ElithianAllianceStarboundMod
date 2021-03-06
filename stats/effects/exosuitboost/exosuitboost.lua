function init()
  local bounds = mcontroller.boundBox()
  
  self.walkSoundTimer = 0.0
  self.jumpSoundPlayed = false
  
  effect.addStatModifierGroup({
	{stat = "fallDamageMultiplier", effectiveMultiplier = 0.75},
	{stat = "jumpModifier", amount = 0.25}
  })
end

function update(dt)
  mcontroller.controlModifiers({
	speedModifier = 1.20,
	airJumpModifier = 1.25
  })
  
  if not status.statPositive("activeMovementAbilities") then
	if mcontroller.jumping() and self.jumpSoundPlayed == false then
      animator.playSound("jump")
	  self.jumpSoundPlayed = true
	
	elseif mcontroller.onGround() then
      self.jumpSoundPlayed = false
	end
  
	if mcontroller.walking() and self.walkSoundTimer <= 0 and mcontroller.onGround() then
      animator.playSound("move")
	  self.walkSoundTimer = 0.4
	end
  
	if mcontroller.running() and self.walkSoundTimer <= 0 and mcontroller.onGround() then
      animator.playSound("move")
	  self.walkSoundTimer = 0.45
	end
	
	world.debugText(self.walkSoundTimer, mcontroller.position(), "red")
  
	if self.walkSoundTimer > 0 and mcontroller.onGround() then
	  self.walkSoundTimer = math.max(0, self.walkSoundTimer - script.updateDt())
	end
  end
end

function uninit()
  
end