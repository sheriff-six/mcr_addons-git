local DLib = DLib
local Notify = DLib.Notify
local insert, remove
do
  local _obj_0 = table
  insert, remove = _obj_0.insert, _obj_0.remove
end
local newLines, allowedOrign, NotifyBase
newLines, allowedOrign, NotifyBase = Notify.newLines, Notify.allowedOrign, Notify.NotifyBase
local NotifyAnimated
do
  local _class_0
  local _parent_0 = NotifyBase
  local _base_0 = {
    GetAnimated = function(self)
      return self.m_animated
    end,
    GetIsAnimated = function(self)
      return self.m_animated
    end,
    GetAnimatedIn = function(self)
      return self.m_animin
    end,
    GetAnimatedOut = function(self)
      return self.m_animout
    end,
    GetFinishFinal = function(self)
      return self.m_finishFinal
    end,
    ResetTimer = function(self)
      _class_0.__parent.__base.ResetTimer(self)
      self.m_finishFinal = self.m_finish + 1
      return self
    end,
    SetLength = function(self, new)
      if new == nil then
        new = 4
      end
      _class_0.__parent.__base.SetLength(self, new)
      self.m_lengthFinal = new + 1
      return self
    end,
    ResetTimer = function(self)
      _class_0.__parent.__base.ResetTimer(self)
      self.m_finishFinal = self.m_finish + 1
      return self
    end,
    SetAnimatedOut = function(self, val)
      if val == nil then
        val = true
      end
      assert(self:IsValid(), 'tried to use a finished Slide Notification!')
      assert(type(val) == 'boolean', 'must be a boolean')
      self.m_animout = val
      return self
    end,
    SetAnimatedIn = function(self, val)
      if val == nil then
        val = true
      end
      assert(self:IsValid(), 'tried to use a finished Slide Notification!')
      assert(type(val) == 'boolean', 'must be a boolean')
      self.m_animin = val
      return self
    end,
    SetAnimated = function(self, val)
      if val == nil then
        val = true
      end
      assert(self:IsValid(), 'tried to use a finished Slide Notification!')
      assert(type(val) == 'boolean', 'must be a boolean')
      self.m_animated = val
      return self
    end,
    SetFinish = function(self, new)
      if new == nil then
        new = CurTimeL() + 4
      end
      _class_0.__parent.__base.SetFinish(self, new)
      self.m_finishFinal = self.m_finish + 1
      return self
    end,
    ThinkNotTimer = function(self, deltaThink)
      self.m_finishFinal = self.m_finishFinal + deltaThink
    end,
    GetNonValidTime = function(self)
      return self.m_finishFinal
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      _class_0.__parent.__init(self, ...)
      self.m_animated = true
      self.m_animin = true
      self.m_animout = true
      self.m_lengthFinal = 5
      self.m_finishFinal = self.m_finish + 1
    end,
    __base = _base_0,
    __name = "NotifyAnimated",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  NotifyAnimated = _class_0
end
Notify.NotifyAnimated = NotifyAnimated
